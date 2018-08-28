defmodule ShowCode do 
  defstruct start_l: 0, end_l: 10

  def show(filename, sl \\ 0, el) when sl < el do 
    IO.write IO.ANSI.light_yellow
    File.open!(filename)
    |> IO.stream(:line)
    |> Enum.slice((sl-1)..(el-1))
    |> IO.puts
    IO.write IO.ANSI.reset
  end
  #def show(filename, _sl, _el) do 
  #  IO.write IO.ANSI.red
  #  IO.puts "#{filename}:line number error:it should be sl < el"    
  #  IO.write IO.ANSI.reset
  #end
end 
