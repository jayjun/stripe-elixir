defmodule Stripe.TokenTest do
  use ExUnit.Case, async: true

  alias Stripe.Token
  alias Stripe.{InvalidRequestError, CardError}

  test "create a token" do
    assert {:ok, token} = Token.create(
      card: [
        number: "4242424242424242",
        exp_month: 7,
        exp_year: 2017,
        cvc: "314"
      ]
    )

    assert {:ok, ^token} = Token.retrieve(token["id"])
  end

  test "card error" do
    assert {:error, %CardError{param: "number", code: "incorrect_number"}} = Token.create(
      card: [
        number: "invalid card number",
        exp_month: 7,
        exp_year: 2017,
        cvc: "314"
      ]
    )
  end

  test "retrieve a token" do
    assert {:error, %InvalidRequestError{message: "No such token: not exist"}}
      = Token.retrieve("not exist")
  end
end
