defmodule Anagrammerator.AnagramControllerTest do
  use Anagrammerator.ConnCase

  test "GET /anagrams/query/AA", %{conn: conn} do
    conn = get conn, "/anagrams/query/AA"
    assert html_response(conn, 200) =~ ["AA"]
  end
end
