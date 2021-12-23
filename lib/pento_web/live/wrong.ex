defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, session, socket) do
    {
      :ok,
      assign(
        socket,
        score: 0,
        message: "Guess a number.",
        time: time(),
        number: number(),
        user: Pento.Accounts.get_user_by_session_token(session["user_token"]),
        session_id: session["live_socket_id"]
      )
    }
  end

  def time() do
    DateTime.utc_now() |> to_string
  end

  def number() do
    number =
      :rand.uniform(10)
      |> Integer.to_string()
  end

  def render(assigns) do
    ~L"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
      It's <%= @time %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number="<%= n %>"><%= n %></a>
      <% end %>
    </h2>
    <prev>
      <%= @user.email %>
      <%= @session_id %>
    </prev>
    """
  end

  def handle_event(
        "guess",
        %{"number" => current} = data,
        %{assigns: %{number: current}} = socket
      ) do
    message = "CORRECT. Keep Getting It! "
    score = socket.assigns.score + 9
    time = time()
    number = number()

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score,
        number: number(),
        time: time
      )
    }
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    message = "Your guess: #{guess}. Wrong. Guess again. "
    score = socket.assigns.score - 1
    time = time()

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score,
        time: time
      )
    }
  end
end
