// Teste l'affichage et la validation de l'interface de connexion.
import 'package:flutter_test/flutter_test.dart'; // Importe les outils de test Flutter.
import 'package:auth_interface/main.dart'; // Importe l'application à tester.

void main() { // Point d'entrée des tests.
  testWidgets('La page de connexion affiche ses champs', (WidgetTester tester) async { // Déclare un test d'interface asynchrone.
    await tester.pumpWidget(const MonApplication()); // Affiche l'application pendant le test.

    expect(find.text('Connexion'), findsOneWidget); // Vérifie la présence du titre.
    expect(find.text('Adresse e-mail'), findsOneWidget); // Vérifie la présence du champ e-mail.
    expect(find.text('Mot de passe'), findsOneWidget); // Vérifie la présence du champ mot de passe.
    expect(find.text('Se connecter'), findsOneWidget); // Vérifie la présence du bouton de connexion.
  }); // Termine le test d'affichage.

  testWidgets('Le formulaire signale les champs vides', (WidgetTester tester) async { // Déclare un test de validation.
    await tester.pumpWidget(const MonApplication()); // Affiche l'application pendant le test.
    await tester.tap(find.text('Se connecter')); // Appuie sur le bouton de connexion.
    await tester.pump(); // Met à jour l'interface après le clic.

    expect(find.text('Saisissez votre adresse e-mail.'), findsOneWidget); // Vérifie le message d'erreur de l'e-mail.
    expect(find.text('Saisissez votre mot de passe.'), findsOneWidget); // Vérifie le message d'erreur du mot de passe.
  }); // Termine le test de validation.
} // Termine la fonction main.