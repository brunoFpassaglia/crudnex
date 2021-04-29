# crudnex

### feito com nullsafety ativado, usar DART sdk > 2.12
### utilizado versão 2.0.5 do flutter
### utilizado versão 3.5 do graddle

Credenciais: bruno@gmail.com / s3nh4d34dm1n
Ao realizar o login, um token ficticio é armazenado localmente, e alguns produtos iniciais são persistidos também localmente;
Ao realizar o logoff, o token e os produtos são apagados, e só serão adicionados novamente em um novo login;
Se fechar o aplicativo sem deslogar os dados não são perdidos;
Pode-se editar os campos de imagem, nome, codigo, preco e quantidade no estoque. O campo updateAt é atualizado em cada operacao de
insert/update;
Pode-se apagar um produto pela pagina principal (catálogo com todos os produtos) ou pela página do produto especifico;
O campo de código não tem validação de unicidade, por não estar utilizando um banco sql no armazenamento, portando se cadastrar um produto,
com mesmo código de um já existente, o mesmo será sobreposto.



A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
