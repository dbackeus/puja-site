module ApplicationHelper
  def page_title
    @page_title || "Puja site [missing @page_title]"
  end

  def country_select_with_priority(form_builder)
    form_builder.input :country, priority: [request.location.country], include_blank: false
  rescue CountrySelect::CountryNotFoundError
    form_builder.input :country, include_blank: false
  end

  def glyph_icon(name)
    %(<span class="glyphicon glyphicon-#{name}"></span>).html_safe
  end

  def accommodation_options
    cabin_label = radio_with_hint(
      "Cabin",
      "Enjoy the comfort of the cabins located near the sea. Each cabin
      can host 7 people, 2 in a king size bedroom, 2 in a bunk bed bedroom and 3 in a upstairs bedroom.
      Blankets and pillows are provided but you will have to bring sheets and towels
      or rent on site for €10. <b>Please consider leaving the limited cabin spaces for senior yogis if you
      can manage staying in the normal collective sleeping tents</b>.<br>Cost: €#{Registration::CABIN_COST} + voluntary donation per person.",
      places_left: Registration.cabin_places_left,
    )
    hostel_label = radio_with_hint(
      "Hostel",
      "Get a bed in one of the 11 available double rooms in the newly renovated
      hostel. Blankets and pillows are provided but you will have to bring sheets and towels
      or rent on site for €10.<br>Cost: €#{Registration::HOSTEL_COST} + voluntary donation per person.",
      places_left: Registration.hostel_places_left,
    )
    tent_label = radio_with_hint(
      "Collective Sleeping Tents",
      "We will erect collective sleeping tents hosting around 100 yogis each.
      They will be heated so should be comfortable even if the nights get cold.
      Don't forget to bring sleeping bags and sleeping mats. You are also welcome
      to bring your own tent.<br>Cost: €#{Registration::TENT_COST} + voluntary donation per person.",
    )

    {
      cabin_label => "cabin",
      hostel_label => "hostel",
      tent_label => "tent",
    }
  end

  def gender_options
    {
      "Male" => "male",
      "Female" => "female",
    }
  end

  def age_options
    {
      "Adult" => "adult",
      "Yuva (13-21)" => "yuva",
      "Child (4-12)" => "child",
      "Small child (0-3)" => "small_child",
    }
  end

  def venue_images
    {
      "56.jpg" => "Beatiful view near camping",
      #"8.jpg" => "Outside some of the sleeping cabins",
      #"12.jpg" => "Camping site facilities",
      "13.jpg" => "Kitchen / Livingroom of cabin",
      #"14.jpg" => "Upper floor bedroom of cabin",
      "15.jpg" => "Cabin living room seen from upper floor",
      #"16.jpg" => "Cabin living room",
      #"17.jpg" => "Cabin veranda",
      "22.jpg" => "Cabin first floor bed room #1",
      #"23.jpg" => "Cabin first floor bed room #2",
      #"27.jpg" => "Outside view of camping site",
      #"38.jpg" => "Hostel buildings and childrens playground",
      "41.jpg" => "Puja hall",
      "45.jpg" => "Nearby community 'Skärhamn'",
    }
  end

  private

  def radio_with_hint(label, hint, places_left: nil)
    extra_info = "- #{places_left} places left" if places_left

    %(<strong>#{label}</strong> #{extra_info} <p data-places-left="#{places_left}" class="help-block">#{hint}</p>).html_safe
  end
end
