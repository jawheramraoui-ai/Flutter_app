import 'package:flutter/material.dart'; // Importe les composants visuels de Flutter.

void main() { // Point d'entrée de l'application.
  runApp(const MonApplication()); // Lance l'application.
} // Termine la fonction main.

class MonApplication extends StatelessWidget { // Définit le widget principal.
  const MonApplication({super.key}); // Constructeur du widget.

  @override // Remplace la méthode build de la classe parente.
  Widget build(BuildContext context) { // Construit l'interface principale.
    return MaterialApp( // Crée une application Material.
      debugShowCheckedModeBanner: false, // Masque la bannière de débogage.
      title: 'Connexion', // Définit le titre de l'application.
      theme: ThemeData( // Configure le thème.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo), // Définit la couleur principale.
        useMaterial3: true, // Active Material 3.
      ), // Termine le thème.
      home: const PageConnexion(), // Affiche la page de connexion.
    ); // Termine MaterialApp.
  } // Termine la méthode build.
} // Termine la classe MonApplication.

class PageConnexion extends StatefulWidget { // Définit une page avec un état modifiable.
  const PageConnexion({super.key}); // Constructeur de la page.

  @override // Remplace la méthode de création de l'état.
  State<PageConnexion> createState() => _PageConnexionState(); // Crée l'état de la page.
} // Termine la classe PageConnexion.

class _PageConnexionState extends State<PageConnexion> { // Contient les données et actions de la page.
  final _formKey = GlobalKey<FormState>(); // Permet de valider le formulaire.
  final _emailController = TextEditingController(); // Contrôle le champ e-mail.
  final _passwordController = TextEditingController(); // Contrôle le champ mot de passe.
  bool _passwordVisible = false; // Indique si le mot de passe est visible.

  @override // Remplace la méthode dispose de la classe parente.
  void dispose() { // Libère les ressources utilisées.
    _emailController.dispose(); // Libère le contrôleur e-mail.
    _passwordController.dispose(); // Libère le contrôleur du mot de passe.
    super.dispose(); // Termine la libération de l'état.
  } // Termine la méthode dispose.

  void _seConnecter() { // Valide les informations saisies.
    if (!_formKey.currentState!.validate()) return; // Arrête l'action si le formulaire est invalide.
    final email = _emailController.text.trim(); // Récupère l'e-mail sans espaces superflus.
    ScaffoldMessenger.of(context).showSnackBar( // Affiche un message temporaire.
      SnackBar(content: Text('Formulaire valide pour $email')), // Confirme que les champs sont valides.
    ); // Termine l'affichage du message.
    // Ajoutez ici l'appel à votre API ou à Firebase pour authentifier l'utilisateur. // La validation seule ne connecte pas à un compte.
  } // Termine la méthode de connexion.

  @override // Remplace la méthode build de la classe parente.
  Widget build(BuildContext context) { // Construit la page de connexion.
    return Scaffold( // Crée la structure de l'écran.
      body: SafeArea( // Évite le chevauchement avec les barres système.
        child: Center( // Centre le contenu.
          child: SingleChildScrollView( // Permet de faire défiler la page si nécessaire.
            padding: const EdgeInsets.all(24), // Ajoute une marge autour du contenu.
            child: ConstrainedBox( // Limite la largeur du formulaire.
              constraints: const BoxConstraints(maxWidth: 420), // Définit la largeur maximale.
              child: Form( // Regroupe les champs du formulaire.
                key: _formKey, // Associe la clé au formulaire.
                child: Column( // Dispose les éléments verticalement.
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Étire les éléments en largeur.
                  children: [ // Commence la liste des éléments.
                    const Icon(Icons.lock_outline, size: 64, color: Colors.indigo), // Affiche une icône de cadenas.
                    const SizedBox(height: 20), // Ajoute un espace.
                    const Text( // Affiche le titre.
                      'Connexion', // Définit le texte du titre.
                      textAlign: TextAlign.center, // Centre le titre.
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold), // Définit le style du titre.
                    ), // Termine le titre.
                    const SizedBox(height: 8), // Ajoute un espace.
                    const Text( // Affiche une instruction.
                      'Connectez-vous avec votre adresse e-mail.', // Définit le texte d'instruction.
                      textAlign: TextAlign.center, // Centre l'instruction.
                    ), // Termine l'instruction.
                    const SizedBox(height: 32), // Ajoute un espace avant le premier champ.
                    TextFormField( // Crée le champ e-mail.
                      controller: _emailController, // Relie le champ à son contrôleur.
                      keyboardType: TextInputType.emailAddress, // Affiche un clavier adapté aux e-mails.
                      textInputAction: TextInputAction.next, // Propose de passer au champ suivant.
                      decoration: const InputDecoration( // Configure le champ.
                        labelText: 'Adresse e-mail', // Affiche le nom du champ.
                        hintText: 'vous@exemple.com', // Affiche un exemple.
                        prefixIcon: Icon(Icons.email_outlined), // Ajoute une icône e-mail.
                        border: OutlineInputBorder(), // Ajoute une bordure.
                      ), // Termine la configuration du champ.
                      validator: (valeur) { // Vérifie l'adresse saisie.
                        final email = valeur?.trim() ?? ''; // Retire les espaces superflus.
                        if (email.isEmpty) return 'Saisissez votre adresse e-mail.'; // Signale un champ vide.
                        final emailValide = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email); // Vérifie le format de l'e-mail.
                        if (!emailValide) return 'Saisissez une adresse e-mail valide.'; // Signale un format incorrect.
                        return null; // Confirme que le champ est valide.
                      }, // Termine la validation de l'e-mail.
                    ), // Termine le champ e-mail.
                    const SizedBox(height: 16), // Ajoute un espace entre les champs.
                    TextFormField( // Crée le champ mot de passe.
                      controller: _passwordController, // Relie le champ à son contrôleur.
                      obscureText: !_passwordVisible, // Masque le texte si le mot de passe n'est pas visible.
                      textInputAction: TextInputAction.done, // Affiche l'action « terminé » sur le clavier.
                      decoration: InputDecoration( // Configure le champ.
                        labelText: 'Mot de passe', // Affiche le nom du champ.
                        prefixIcon: const Icon(Icons.lock_outline), // Ajoute une icône de cadenas.
                        border: const OutlineInputBorder(), // Ajoute une bordure.
                        suffixIcon: IconButton( // Crée le bouton afficher/masquer.
                          onPressed: () { // Définit l'action du bouton.
                            setState(() { // Demande à Flutter de reconstruire l'interface.
                              _passwordVisible = !_passwordVisible; // Inverse la visibilité du mot de passe.
                            }); // Termine la mise à jour de l'état.
                          }, // Termine l'action du bouton.
                          icon: Icon(_passwordVisible ? Icons.visibility_off : Icons.visibility), // Affiche l'icône adaptée.
                        ), // Termine le bouton afficher/masquer.
                      ), // Termine la configuration du champ.
                      validator: (valeur) { // Vérifie le mot de passe.
                        if (valeur == null || valeur.isEmpty) return 'Saisissez votre mot de passe.'; // Signale un champ vide.
                        if (valeur.length < 8) return 'Le mot de passe doit contenir au moins 8 caractères.'; // Vérifie sa longueur.
                        return null; // Confirme que le champ est valide.
                      }, // Termine la validation du mot de passe.
                      onFieldSubmitted: (_) => _seConnecter(), // Lance la validation depuis le clavier.
                    ), // Termine le champ mot de passe.
                    Align( // Aligne le lien à droite.
                      alignment: Alignment.centerRight, // Définit l'alignement à droite.
                      child: TextButton( // Crée le bouton « mot de passe oublié ».
                        onPressed: () {}, // Ajoutez ici votre action de réinitialisation du mot de passe.
                        child: const Text('Mot de passe oublié ?'), // Affiche le texte du lien.
                      ), // Termine le bouton.
                    ), // Termine l'alignement.
                    const SizedBox(height: 12), // Ajoute un espace avant le bouton de connexion.
                    SizedBox( // Définit la taille du bouton.
                      height: 52, // Définit la hauteur du bouton.
                      child: FilledButton( // Crée le bouton de connexion.
                        onPressed: _seConnecter, // Appelle la validation lorsque le bouton est pressé.
                        child: const Text('Se connecter'), // Affiche le texte du bouton.
                      ), // Termine le bouton.
                    ), // Termine le conteneur du bouton.
                  ], // Termine la liste des éléments.
                ), // Termine la colonne.
              ), // Termine le formulaire.
            ), // Termine la contrainte de largeur.
          ), // Termine le défilement.
        ), // Termine le centrage.
      ), // Termine la zone sûre.
    ); // Termine l'écran.
  } // Termine la méthode build.
} // Termine la classe d'état.