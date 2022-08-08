
const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().functions);


var newData
 exports.myNotifacionConsul = functions.https.onCall(async (data, context) => {

     var tokens = data['token'];
     var idDocumento=data['idNotificacion'];

     await admin.firestore()
             .collection('notificacion')
             .doc(idDocumento)
             .update({'estado':'Realizado'});
     await admin.firestore()
      .collection('notificacion')
      .doc(idDocumento)
      .get()
      .then(documentSnapshot => {

        console.log('User exists: ', documentSnapshot.exists);

        if (documentSnapshot.exists) {
          newData=documentSnapshot.data();
          console.log('User data: ', documentSnapshot.data());
        }
      });
     var payload = {
         notification: {
             title: newData['titulo'],
             body: newData['cuerpo'],
             sound: 'default',
         },
         data: {
             click_action: 'FLUTTER_NOTIFICATION_CLICK',
             message: 'FLUTTER_NOTIFICATION_CLICK',
         },
     };

     try {
         const response = await admin.messaging().sendToDevice(tokens, payload);
         console.log('Notification sent successfully');
     } catch (err) {
         console.log(err);
     }
 });

