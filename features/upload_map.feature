Feature: Téléversement d'une carte
  En tant qu'administrateur connecté
  Je veux pouvoir téléverser une carte du cégep
  Afin de pouvoir la visualiser

  Scenario: L'administrateur peut téléverser une carte
    Given Administrateur connecté
    When Dans le formulaire de téléversement
    Then Une carte est téléverser