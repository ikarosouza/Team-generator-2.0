module ApplicationHelper
  def nav_link_to(name, path)
    classes = ["nav-link"]
    classes << "active" if current_page?(path)
    link_to name, path, class: classes.join(" ")
  end

  def athlete_level_icons(level)
    safe_join(Array.new(level.to_i) { tag.i(class: "fa-solid fa-futbol text-warning me-1") })
  end

  def athlete_guest_badge(guest)
    if guest
      tag.span("Convidado", class: "badge text-bg-info")
    else
      tag.span("Regular", class: "badge text-bg-success")
    end
  end
end
