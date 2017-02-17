Feature: Carte des locaux du cégep
  En tant qu'administrateur connecté
  Je veux voir la carte des locaux du cégep
  Afin de pouvoir valider celle-ci

  Scenario: L'utilisateur voit la carte du cégep
    Given Administrateur connecté
    When Les locaux sur affichés
    Then Valide la carte