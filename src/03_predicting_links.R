
predictLink <- function(link, cutoff=0.5){
  
  # Pre-processing a new link
  root_path <- getwd()
  model_path <- paste0(root_path, "/data/links_rf_model.rds")
  
  print(dir(paste0(root_path, "/data")))
  print(model_path)

  my_model <- load(model_path)
  
  link_cleaned <- gsub("https://", "", link)
  link_cleaned <- gsub("/", " ", link_cleaned)
  link_cleaned <- gsub("-", " ", link_cleaned)
  
  # Step 1 - Create a corpus text
  corpus = Corpus(VectorSource(link_cleaned))
  
  ## Step 2 - Conversion to Lowercase
  corpus = tm::tm_map(corpus, PlainTextDocument)
  corpus = tm::tm_map(corpus, tolower)
  
  #Step 3 - Removing Punctuation
  corpus = tm::tm_map(corpus, removePunctuation)
  
  #Step 4 - Removing Stopwords and other words
  corpus = tm::tm_map(corpus, removeWords, c("http", stopwords("portuguese")))
  
  corpus = tm::tm_map(corpus, removeNumbers)
  
  # Step 5 - Stemming: reducing the number of inflectional forms of words
  corpus = tm::tm_map(corpus, stemDocument)
  
  # Step 6 - Create Document Term Matrix
  frequencies = tm::DocumentTermMatrix(corpus)
  #sparse = removeSparseTerms(frequencies, 0.995) #remove sparse terms
  tSparse_nonamed = as.data.frame(as.matrix(frequencies)) #convert into data frame
  
  tSparse <- tSparse_nonamed
  colnames(tSparse) = make.names(colnames(tSparse_nonamed)) #all the variable names R-friendly
  
  present_vars <- my_model$finalModel$xNames %in% colnames(tSparse)
  missing_vars <- !present_vars
  missing_vars <- my_model$finalModel$xNames[missing_vars]
  extra_vars_matrix <- matrix(0, ncol = length(missing_vars), nrow = nrow(tSparse))
  colnames(extra_vars_matrix) <- missing_vars
  
  new_examples_matrix <- cbind(tSparse, extra_vars_matrix)
  
  # Predicting link
  
  predictions <- predict(my_model, new_examples_matrix, type = "prob")
  predictions_yes <- predictions[, 2]
  papers_predicted <- ifelse(predictions_yes >= cutoff, "True", "Fake")
  papers_predicted_df <- data.frame(Score = predictions_yes, Prediction = papers_predicted)
  papers_predicted_df

}
