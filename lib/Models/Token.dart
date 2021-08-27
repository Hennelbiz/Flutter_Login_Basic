class Token
{
  String? accessToken;
  String? tokenType;
  String? usuario;
  String? tokenSyGlobal;

  Token(String accessToken, String tokenType, String usuario, String tokenSyGlobal) //: accessToken = accessToken
  {
    this.accessToken = accessToken;
    this.tokenType = tokenType;
    this.usuario = usuario;
    this.tokenSyGlobal = tokenSyGlobal;
  }
}