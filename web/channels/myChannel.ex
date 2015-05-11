defmodule ChatDb.MyChannel do
  use Phoenix.Channel

  def join("rooms:lobby", auth_msg, socket) do
    {:ok, socket}
  end
  
  def join("rooms:" <> _private_room_id, _auth_msg, socket) do
    :ignore
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast! socket, "new_msg", %{body: body}
    {:noreply, socket}
  end

  def handle_out("new_msg", payload, socket) do
    push socket, "new_msg", payload
    {:noreply, socket}
  end

  def handle_in("read", %{"body" => body}, socket) do
    broadcast! socket, "read", %{body:  "#{body}" }
    {:noreply, socket}
  end

  def handle_out("read", payload, socket) do
    push socket, "read", payload
    {:noreply, socket}
  end
end