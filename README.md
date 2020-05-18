# veraapi-model
Treinamento de um modelo random forest em R a partir de links de notícias verdadeiras e falsas. O modelo é base para uma API hospedada em <https://www.opencpu.org/cloud.html> que recebe links (URLs) de notícias e retorna como resposta se a notícia provavelmente é verdadeira ou falsa.

## Inspiração
A proliferação desenfreada de notícias falsas e os problemas sociais que ela acarreta, em especial em relação à saúde pública dado o cenário atual, inspiraram uma série de iniciativas. Entre elas estão o [link](http://www.euro.who.int/en/health-topics/health-emergencies/coronavirus-covid-19/healthbuddy ) [Health Buddy], um chatbot desenvolvido pela Unicef que responde dúvidas comuns e aceita denúncias de notícias falsas, o canal de mensagens Saúde sem Fake News desenvolvido pelo Ministério da Saúde e o aplicativo Eu Fiscalizo, da Fiocruz, que aceita denúncias de notícias falsas.

# Como construímos
Utilizamos como base o trabalho Towards automatically filtering fake news in Portuguese, por Renato M. Silva, Roney L. S. Santos, Tiago A. Almeida, Thiago A. S. Pardo [link](https://doi.org/10.1016/j.eswa.2020.113199) para treinar um modelo de Machine Learning, com dados do fake.br Corpus [link](https://github.com/roneysco/Fake.br-Corpus). 
