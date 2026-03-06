from datetime import date, datetime
import pytest
from pytest_bdd import scenarios, given, when, then, parsers

from core.expense_service import ExpenseService
from core.in_memory_expense_repository import InMemoryExpenseRepository

scenarios("./expense_management.feature")


@pytest.fixture
def context():
    repo = InMemoryExpenseRepository()
    service = ExpenseService(repo)
    return {"service": service, "db": repo, "gastos_mensuales": service.total_by_month}


@given(parsers.parse("un gestor de gastos vacío"))
def empty_manager(context):
    pass


@given(parsers.parse("un gestor con un gasto de {amount:d} euros"))
def manager_with_one_expense(context, amount):
    context["service"].create_expense(
        title="Gasto inicial", amount=amount, description="", expense_date=date.today()
    )


@when(parsers.parse("añado un gasto de {amount:d} euros llamado {title}"))
def add_expense(context, amount, title):
    context["service"].create_expense(
        title=title, amount=amount, description="", expense_date=date.today()
    )


@when(parsers.parse("añado un gasto de {amount:d} euros del {fecha} llamado {title}"))
def add_expense_with_mount(context, amount, title, fecha):
    fecha_date = datetime.strptime(fecha, "%Y-%m").date()
    context["service"].create_expense(
        title=title, amount=amount, description="", expense_date=fecha_date
    )


@when(parsers.parse("elimino el gasto con id {expense_id:d}"))
def remove_expense(context, expense_id):
    context["service"].remove_expense(expense_id)


@when(
    parsers.parse("actualizo el gasto con id {expense_id:d} a un gasto de {amount:d}")
)
def update_amount(context, expense_id, amount):
    context["service"].update_expense(expense_id, amount=amount)


@when(parsers.parse("actualizo el gasto con id {expense_id:d} a un gasto del {fecha}"))
def update_date(context, expense_id, fecha):
    fecha_date = datetime.strptime(fecha, "%Y-%m").date()
    context["service"].update_expense(expense_id, expense_date=fecha_date)


@when(
    parsers.parse(
        "actualizo el gasto con id {expense_id:d} a un gasto con titulo {title}"
    )
)
def update_title(context, expense_id, title):
    context["service"].update_expense(expense_id, title=title)


@then(parsers.parse("el total de dinero gastado debe ser {total:d} euros"))
def check_total(context, total):
    assert context["service"].total_amount() == total


@then(parsers.parse("el titulo del gasto con id {expense_id:d} es {title}"))
def check_title(context, expense_id, title):
    assert context["service"].list_expenses()[expense_id - 1].title == title


@then(parsers.parse("{month_name} debe sumar {expected_total:d} euros"))
def check_month_total(context, month_name, expected_total):
    total_actual = context["gastos_mensuales"]().get(month_name, 0)
    assert total_actual == expected_total


@then(parsers.parse("debe haber {expenses:d} gastos registrados"))
def check_expenses_length(context, expenses):
    total = len(context["db"]._expenses)
    assert expenses == total
