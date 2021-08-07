import 'package:flutter/cupertino.dart';


class Texts with ChangeNotifier{
  bool isFrench;

  setLanguage(bool newValue){
    isFrench = newValue;
    notifyListeners();
  }
  ///***************************Landing page
  String getTitreAppBarLandingPage(){
    return isFrench? "Annuaire" : "الدليل";
  }

  String getMenu(){
    return isFrench? "Menu" : "القائمة";
  }
  String getPlan(){
    return isFrench? "Plan" : "خريطة";
  }
  String getRechDansLann(){
    return isFrench? "Rechercher dans l'annuaire":"ابحث في الدليل";
  }
  String getLandingExemple(){
    return isFrench? "Exemples : Maitre Hocini, Maitre Saidi, ...": "..." +", مثال : الاستاذ حسيني, الاستاذ سعيدي";
  }
  String getRechParCat(){
    return isFrench? "Rechercher par catégorie" : "بحث حسب الفئة";
  }
  String inscrivezvous(){
    return isFrench? "Praticien? Inscrivez-vous!" : " ! استاذ؟ سجل نفسك";
  }
  
  ///***************************Signup
  String demandeDins(){
    return isFrench? "Demande D'inscription" : "طلب تسجيل";
  }
  String nomHint(){
    return isFrench? "Nom : ..................." : "اللقب : ....................";
  }
  String prenomHint(){
    return isFrench? "Prénoms : ..............." : "الاسم : ....................";
  }
  String telHint(){
    return isFrench? "N° de téléphone : ......." : "رقم الهاتف : ....................";
  }
  String adrHint(){
    return isFrench? "Adresse exacte : ........" : "عنوان : ....................";
  }
  String emailHint(){
    return isFrench? "Email : ................." : "البريد الإلكتروني : ....................";
  }
  String specHint(){
    return isFrench? "Spécialité : ............" : "تخصص : ....................";
  }
  String horaireHint(){
    return isFrench? "Horaire d'ouverture :...." : "اوقات الفتح : ....................";
  }
  String detailsHint(){
    return isFrench? "Autres détails : ........" : "المزيد من التفاصيل : ....................";
  }
  String wilayaHint(){
    return isFrench? "Wilaya : ................." : "الولاية : ....................";
  }
  String communeHint(){
    return isFrench? "Commune : ................" : "البلدية : ....................";
  }
  String envDemande(){
    return isFrench? "Envoyer la demande" : "ارسال الطلب";
  }
  ///***************************Home Page
  String resultats(int total){
    return isFrench? total.toString() + " résultats correspendent à votre recherche" : total.toString() + " : نتائج تطابق بحثك ";
  }
  String nomPrenom(String nom, String prenom, String nomAr, String prenomAr){
    return isFrench? "Maitre "+nom+" "+prenom : " الأستاذ "+ nomAr+" "+prenomAr;
  }
  ///***************************bout us
  String apropos(){
    return isFrench? "A propos" : "معلومات عنا";
  }

  ///***************************Contact us
  String votreNom(){
    return isFrench? 'Votre nom *' : 'اسمك *';
  }
  String votreEmail(){
    return isFrench? 'Votre adresse de messagerie *' : 'عنوان بريدك الإلكتروني *'; 
  }
  String objet(){
    return isFrench? 'Objet' : 'موضوع';
  }
  String message(){
    return isFrench? 'Votre Message * ' : 'محتوى رسالتك *';
  }


  ///***************************Custom Drawer
  String guideJustice(){
    return isFrench? "Guide Justice" : "الدليل";
  }
  String accueil(){
    return isFrench? "Accueil" : "الصفحة الرئيسية";
  }
  String sinscrire(){
    return isFrench? "S'inscrire" : "صفحة التسجيل";
  }
  String profil(){
    return isFrench? "Profil" : "الصفحة الشخصية";
  }
  String nousContacter(){
    return isFrench? "Nous contacter" : "اتصل بنا";
  }
  String params(){
    return isFrench? "Paramètres" : "الإعدادات";
  }
  ///***************************Profile
  String email(){
    return isFrench? "Email" : "البريد الإلكتروني";
  } 
  String mtp(){
    return isFrench? "Mot de passe" : "كلمة السر";
  }
  String errEmail(){
    return isFrench? 'Veuillez Introduire Un Email Valide' : 'يرجى تقديم بريد إلكتروني صالح';
  }
  String errMtp(){
    return isFrench? 'Veuillez Introduire Un Mot de passe' : 'يرجى تقديم كلمة مرور صالحة';
  }
  String pum(){
    return isFrench? 'Pas Un Membre?' : ' غير مشترك؟';
  }
  String inscrivezVous(){
    return isFrench? ' Inscrivez-vous !' : '! سجل نفسك ';
  }
  String seCon(){
    return isFrench? 'Se connecter' : 'تسجيل الدخول';
  }

  //Profil*********************
  String nomFr(){
    return isFrench? 'Nom en Français : ' : 'اللقب بالفرنسية : ';
  }
  String nomAr(){
    return isFrench? 'Nom en Arabe : ' : ' اللقب بالعربي : ';
  }
  String prenomFr(){
    return isFrench? 'Prénoms en Français : ' : 'الاسم بالفرنسية : ';
  }
  String prenomAr(){
    return isFrench? 'Prénoms en Arabe : ' : ' الاسم بالعربي : ';
  }
  String adresse(){
    return isFrench? 'Adresse exacte : ' : "عنوان : ";
  }
  String numero(){
    return isFrench? "N°Telephone : " : "رقم الهاتف : ";
  }
  String horraire(){
    return isFrench? "Horaire d'ouverture : " : "اوقات الفتح : ";
  }
}