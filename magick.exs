defmodule TestMagick do
  @doc """
  Generates an image using first name and last name of a user using imagermagick's convert command line tool.
  """
  @spec create_from_initials(binary, binary) :: {:ok, binary}
  def create_from_initials(first_name, last_name) when
  byte_size(first_name) > 0 and byte_size(last_name) > 0 do
    size = 512
    resolution = 72
    sampling_factor = 3
    background_color = "#003366"
    text_color = "#FFFFFF"
    initials = "#{String.at(first_name, 0)}#{String.at(last_name, 0)}"
    image_path = System.tmp_dir!() |> Path.join("#{initials}.png")

    System.cmd("convert", [
      # sample up
      "-dencity",
      "#{resolution * sampling_factor}",
      # corrected size
      "-size",
      "#{size * sampling_factor}x#{size * sampling_factor}",
      # background color
      "canvas:#{background_color}",
      # text color
      "-fill",
      text_color,
      # font location
      "-font",
      Application.app_dir(:my_app, "priv/fonts/SourceSansPro-Regular.otf"),
      # font size
      "-pointsize",
      "300",
      # center text
      "-gravity",
      "center",
      # render text in the center
      "-annotate",
      "+0+0",
      "#{initials}",
      # sample down to reduce aliasing
      "-resample",
      "#{resolution}",
      image_path
    ])
    {:ok, image_path}
  end
end
