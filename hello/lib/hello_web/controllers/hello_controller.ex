defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  plug :put_headers, %{content_encoding: "gzip", cache_control: "max-age=3600"}

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"id" => id }) do
    render(conn, "show.html", id: id)
  end
  
  def put_headers(conn, key_values) do
    Enum.reduce key_values, conn, fn {k, v}, conn ->
    Plug.Conn.put_resp_header(conn, to_string(k), v)
    end
  end

end
