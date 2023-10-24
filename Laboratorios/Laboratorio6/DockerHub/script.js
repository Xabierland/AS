function doPost(request)
{
  var postJSON = request.postData.getDataAsString();
  var payload = JSON.parse(postJSON);
  var tag = payload.push_data.tag;
  var reponame = payload.repository.repo_name;
  var dockerimagename = payload.repository.name;
  if(typeof request !== 'undefined')

  MailApp.sendEmail({
    to: "xabierland@gmail.com",
    subject: "Nueva imagen subida al repositorio "+reponame,
    htmlBody: "Hola,<br>"+
      "Se ha actualizado el repositorio Docker Hub: "+reponame+"<br>"+
      "<strong>Imagen: " + dockerimagename+"<br>"+
      "Version:" +tag+"<br></strong>"
    });
}