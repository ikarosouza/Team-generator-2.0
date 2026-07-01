import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item", "toggle"]

  connect() {
    this.syncToggleState()
  }

  toggleAll(event) {
    const checked = event.currentTarget.checked
    this.itemTargets.forEach((item) => {
      item.checked = checked
    })
    this.syncToggleState()
  }

  syncToggleState() {
    if (!this.hasToggleTarget) return

    const allChecked = this.itemTargets.length > 0 && this.itemTargets.every((item) => item.checked)
    this.toggleTarget.checked = allChecked
  }
}
