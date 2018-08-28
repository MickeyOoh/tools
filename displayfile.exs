defprotocol Display do 
  @fallback_to_any true
  def show(value)
end
defimpl Display, for: [List, Tuple, BitString, Map] do 
  def is_collection?(_), do: true
end
defimpl Display, for: Any do 
  def is_collection?(_), do: false
end

defmodule Display do 
  def show(file_name) do 
    text = File.read!(file_name)
    Enum.join([IO.ANSI.green, text, IO.ANSI.reset], "")
    |> IO.puts
  end
end

defmodule Test do 
  Display.show(__ENV__.file)
  Enum.each [ 1, 1.0, [1, 2], {1,2}, %{}, "cat"], fn value ->
    IO.puts "#{inspect value}: #{Collection.is_collection?(value)}"
  end
end

