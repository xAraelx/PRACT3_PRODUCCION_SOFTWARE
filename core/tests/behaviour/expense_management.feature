Feature: Gestión de gastos
  Como estudiante
  Quiero registrar mis gastos
  Para controlar cuánto dinero gasto

  Scenario: Crear un gasto y comprobar cual es el total que llevo gastado
    Given un gestor de gastos vacío
    When añado un gasto de 5 euros llamado Café
    Then el total de dinero gastado debe ser 5 euros

  Scenario: Eliminar un gasto y comprobar cual es el total que llevo gastado
    Given un gestor con un gasto de 5 euros
    When elimino el gasto con id 1
    Then debe haber 0 gastos registrados

  Scenario: Crear y eliminar un gasto y comprobar que no he gastado dinero
    Given un gestor de gastos vacío
    When añado un gasto de 5 euros llamado Café
    And elimino el gasto con id 1
    Then debe haber 0 gastos registrados

  Scenario: Crear dos gastos diferentes y comprobar que el total que llevo gastado es la suma de ambos
    Given un gestor de gastos vacío
    When añado un gasto de 5 euros llamado Café
    And añado un gasto de 10 euros llamado Comida
    Then el total de dinero gastado debe ser 15 euros

  Scenario: Crear tres gastos diferentes que sumen 30 euros hace que el total sean 30 euros
    Given un gestor de gastos vacío
    When añado un gasto de 10 euros llamado Café
    And añado un gasto de 10 euros llamado Comida
    And añado un gasto de 10 euros llamado Postre
    Then el total de dinero gastado debe ser 30 euros

  Scenario: Crear tres gastos de 10, 30, 30 euros y elimino el ultimo gasto la suma son 40 euros
    Given un gestor de gastos vacío
    When añado un gasto de 10 euros llamado Café
    And añado un gasto de 30 euros llamado Comida
    And añado un gasto de 30 euros llamado Postre
    And elimino el gasto con id 3
    Then el total de dinero gastado debe ser 40 euros

  Scenario: Crear tres gastos de 10 euros de 2024-05, 15 euros de 2025-01, 20 euros de 2026-02 y comprobamos el total y el gasto de Mayo del 2024
    Given un gestor de gastos vacío
    When añado un gasto de 10 euros del 2024-05 llamado Café
    And añado un gasto de 15 euros del 2025-01 llamado Comida
    And añado un gasto de 20 euros del 2026-02 llamado Postre
    Then el total de dinero gastado debe ser 45 euros
    And 2024-05 debe sumar 10 euros

  Scenario: Crear un gasto de 10 del 2025-11 con el titulo Ropa y cambia el titulo a RegalosNavidad , despues la fecha a 2025-12 y la cantidad a 50
    Given un gestor de gastos vacío
    When añado un gasto de 10 euros del 2025-11 llamado Ropa
    And actualizo el gasto con id 1 a un gasto con titulo RegalosNavidad
    And actualizo el gasto con id 1 a un gasto del 2025-12
    And actualizo el gasto con id 1 a un gasto de 50
    Then 2025-12 debe sumar 50 euros
    And el titulo del gasto con id 1 es RegalosNavidad

  Scenario: Crear un gasto de 100 del 2026-01 con el titulo Tele y cambia el titulo a Consola y despues la fecha a 2025-12 , eliminarlo y comprobar que no este
    Given un gestor de gastos vacío
    When añado un gasto de 100 euros del 2026-01 llamado Tele
    And actualizo el gasto con id 1 a un gasto con titulo Consola
    And actualizo el gasto con id 1 a un gasto del 2025-12
    And elimino el gasto con id 1
    Then debe haber 0 gastos registrados
