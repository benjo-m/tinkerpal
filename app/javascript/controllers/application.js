import { Application } from "@hotwired/stimulus"

document.addEventListener("turbo:frame-load", (event) => {
    const frame = event.target
    const validIds = ["tasks", "offers", "tinkers"]
    if (validIds.includes(frame.id))
        window.scrollTo({ top: 0, behavior: "smooth" })
})

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export { application }
