static Future<int> changeUserImg(String user, String path) async {

    print('####################################################################$title ,$path');
    print(_sessionToken);
    var res;
    var uri = Uri.parse(_URL_METADATA + _USER_IMG);
    var request = new http.MultipartRequest('POST', uri);
    var file = await http.MultipartFile.fromPath('data', file  ); //contentType: MediaType('multipart','form-data')
    print(path);
    //request.headers.addAll({"Content-Type": "multipart/form-data", "Authorization":_sessionToken, "Accept":"multipart/form-data"});
    request.headers["Authorization"]=_sessionToken;
    request.fields.addAll({"path":path, "user":user});
    request.files.add(file);
    await request.send().then( (response) {
      res = response;
      http.Response.fromStream(response).then((r){
        return r.body;
      }).then((r){
        print(r);
      });

    });
    print('upload ${res.statusCode}');

    if (res.statusCode == 201 || res.statusCode == 200) {
      // document created
      // nel response.body viene tornato uuid, titolo, tipo e creatore del documento
      return 1;
    }
    else if (res.statusCode == 400){
      return -1;
    }
    else if (res.statusCode == 500){
      return -2;
    }
    return -3;
  }


