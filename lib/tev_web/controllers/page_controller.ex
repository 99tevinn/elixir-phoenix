defmodule TevWeb.PageController do
  use TevWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def users(conn, _params) do
    users = [
      %{id: 1, name: "Tevin", email: "tevin@gmail.com"},
      %{id: 2, name: "Sevin", email: "Sevin@gmail.com"}
    ]
    render(conn, :users, users: users, layout: false)

    json(conn, %{users: users})
  end
end
