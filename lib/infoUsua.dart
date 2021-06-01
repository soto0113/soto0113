class classUsuarios {
  List<classUsuarios> listaUser;
  String nombre;
  String cel;
  String identificacion;
  String genero;
  classUsuarios(
      String nombre2,
      String cel2,
      String identificacion2,
      String genero2,) 
  {
    this.nombre = nombre2;
    this.cel = cel2;
    this.identificacion = identificacion2;
    this.genero = genero2;
  }

  void newUsuario(
    String nombre1,
    String cel1,
    String identificacion1,
    String genero1,
  ) {}

  List<classUsuarios> getLista() {
    return listaUser;
  }

  String getnombre() {
    return nombre;
  }

  void setnombre(String Nombre) {
    this.nombre = Nombre;
  }

  String getcel() {
    return cel;
  }

  void setcel(String Cel) {
    this.cel = Cel;
  }

  String getidentificacion() {
    return identificacion;
  }

  void setidentificacion(String Identificacion) {
    this.identificacion = Identificacion;
  }

  String getgenero() {
    return genero;
  }

  void setgenero(String Genero) {
    this.genero = Genero;
  }

  void agregarUsuario23(
      String nombre2,
      String cel2,
      String identificacion2,
      String genero2,
      ) {
    this.nombre = nombre2;
  }
}