defmodule NotReadyCell do
  @moduledoc false

  use Kino.JS
  use Kino.JS.Live
  use Kino.SmartCell, name: "Not Ready Cell"

  @impl true
  def to_source(_) do
    quote do
      IO.puts("Not ready reading drive A")
      IO.puts("Abort, Retry, Fail?")
    end
    |> Kino.SmartCell.quoted_to_string()
  end

  @impl true
  def to_attrs(_), do: %{}

  @impl true
  def handle_connect(ctx) do
    {:ok, %{}, ctx}
  end

  asset "main.js" do
    """
    export function init(ctx, payload) {
    }
    """
  end
end

"""
export function init(ctx, payload) {
  root.innerHTML = `
    <div>Say what?</div>
    <input type="text" id="text" />
  `;

  const textEl = document.getElementById("text");
  textEl.value = payload.text;

  ctx.handleEvent("update_text", (text) => {
    textEl.value = text;
  });

  textEl.addEventListener("change", (event) => {
    ctx.pushEvent("update_text", event.target.value);
  });

  ctx.handleSync(() => {
    // Synchronously invokes change listeners
    document.activeElement &&
      document.activeElement.dispatchEvent(new Event("change"));
  });
}
"""
