defmodule ElmBlogger.EditorChannel do
  use Phoenix.Channel

  def join("editor:other", _message, socket) do
    IO.puts("joining other")
    {:ok, socket}
  end

  def handle_in("new_msg", incoming_string, socket) do
    IO.puts "*******************#{incoming_string}"
    broadcast! socket, "new_msg", %{status: :ok, response: "hello"}
    {:noreply, socket}
  end

  def handle_out("new_msg", payload, socket) do
    push socket, "new_msg", payload
    {:noreply, socket}
  end
end
