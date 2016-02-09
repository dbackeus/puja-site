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
      "Enjoy the comfort of the lovely cabins located near the sea. Each cabin can host 7 people, 3 in a downstairs bedroom and 4 in a upstairs bedroom. No sleeping bags or sheets required.<br>Cost: €108 per person.",
      places_left: 88,
    )
    hostel_label = radio_with_hint(
      "Hostel",
      "Get a bed in one of the 11 available double rooms in the newly renovated hostel. No sleeping bags or sheets required.<br>Cost: €120 per person.",
      places_left: 25,
    )
    tent_label = radio_with_hint(
      "Collective Sleeping Tents",
      "We will erect collective sleeping tents hosting around 100 yogis each. They will be heated so should be comfortable even if the nights get cold. Don't forget to bring sleeping bags and sleeping mats. If you prefer you can also bring your own tent.<br>Cost: €55 per person.",
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
      "Child (12 or younger)" => "child",
      "Yuva (13-21)" => "yuva",
    }
  end

  private

  def radio_with_hint(label, hint, places_left: nil)
    extra_info = "- #{places_left} places left" if places_left

    %(<strong>#{label}</strong> #{extra_info} <p class="help-block">#{hint}</p>).html_safe
  end
end
