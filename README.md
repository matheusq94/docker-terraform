### RODANDO A APLICAÇÃO:
- Certifique-se de ter o Docker instalado na máquina.
- Acesse o diretório raiz da aplicação através do terminal e rode ```docker-compose up``` (certifique-se de estar com o Docker rodando).


### PROVISIONANDO A INFRAESTRUTURA E DEPLOY (AWS):
- Certifique-se de ter o Terraform e o Docker instalado (e rodando) na máquina.
- Crie uma conta na AWS e faça o login no console.
- Procure pelo serviço IAM para criar um usuário que vamos utilizar pra provisionar nossa infraestrutura através do Terraform.
- Em seguida, clique em Usuários no menu esquerdo e em seguida no botão Adicionar usuários.
- Preencha os dados com um nome a sua escolha e marque as duas opções em Tipos de acesso.
- No próximo passo, selecione a caixa Anexar politicas existentes de forma direta, marque a caixa AdministratorAccess e avance.
- Na próxima tela você, você receberá sua Access Key ID e sua Secret Access Key, guarde-as.
- De volta ao nosso projeto, abra o arquivo [provider.tf](https://github.com/matheusq94/docker-terraform/blob/main/provider.tf) e insira sua access key e secret key no local indicado (provider “aws”).
-  Salve o arquivo e rode ```terraform init -reconfigure```.
- Em seguida, rode ```terraform apply -lock=false```.
- Aguarde... no final do processo você receberá uma URL para visualizar a aplicação funcionando.