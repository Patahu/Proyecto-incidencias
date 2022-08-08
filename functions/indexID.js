
const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().functions);


const db = admin.firestore();


var newData
var siguiente
 exports.myid = functions.https.onCall(async (data, context) => {


     await db.collection('contador')
      .doc('index')
      .get()
      .then(documentSnapshot => {

        console.log('User exists: ', documentSnapshot.exists);

        if (documentSnapshot.exists) {
          newData=documentSnapshot.data();
          siguiente=documentSnapshot.data().id;

          console.log('User data: ', siguiente);
        }
      });

      let myGeoPoint = new admin.firestore.GeoPoint(data.latitude, data.longitude);
      let idString = siguiente.toString();
      let descripcion=data.descripcion;
      let tipo=data.tipo;
      let estado=data.estado;
      let fechaE=data.fechaE;
      let fechaR=data.fechaR;
      let idFotos=data.idFotos;
      let video=data.video;
      let idUsuario=data.idUsuario;
      await db.collection('IncidenciasAtenderF')
              .doc(idString)
              .set({
              descripcion:descripcion,
              localizacion:myGeoPoint,
              fecha:new Date(),
              tipo:tipo,
              idIncidencia:idString,
              idUsuario:idUsuario,
              estado:estado,
              fechaE:fechaE,
              fechaR:fechaR,
              idFotos:idFotos,
              video:video,
              });
      const resetRef =  await db
        .collection('contador')
        .doc('index')
      resetRef.get().then((doc) => {
            if(doc.exists){
                resetRef.update({id: siguiente+1})
                  .catch(err => {
                console.log("Error",err)

              })
           }
        }).catch(err=>{
            //Internal server error
            console.log("Error",err)

        });
      //Successful operation


 });

