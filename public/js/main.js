// JS Document

//console.log("Test");

if(document.getElementById("resetPost")) {
   const resetPost = document.getElementById("resetPost");

   resetPost.addEventListener("click", function(event) {
      let conf = confirm("Confirmer-vous la suppression ? Cette action est irréversible.");

      if(conf == true) {
         // We validate the sending of the form
         this.form.submit();
      }
   });

   /*if(varBack.loopElementId[1]) {
      for(let i = 0; i < Object.keys(varBack.loopElementId[1]).length; i++) {
         // Voir fichier administrateurs.phtml ligne 136
         if(document.getElementById(varBack.loopElementId[1][i])) {
            const loopElementId = document.getElementById(varBack.loopElementId[1][i]);

            loopElementId.addEventListener("click", function(event) {
               // Voir fichier administrateurs.php ligne 321
               let conf = confirm(varBack.loopMsgConfirm);

               if(conf != true) {
                  event.preventDefault();
               }
            });
         }
      }
   }*/
}