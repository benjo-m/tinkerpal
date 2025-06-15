import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "imagesContainer", "deleteBtn"]

    connect() {
        this.files = []
    }

    handleFiles() {
        this.files = [...this.files, ...Array.from(this.inputTarget.files)];
        this.createImageDivs();
        this.updateInputFiles()
    }

    createImageDivs() {
        Array.from(this.inputTarget.files).forEach((file, index) => {
            const wrapper = document.createElement("div");
            wrapper.classList.add("relative", "m-2");

            const img = document.createElement("img");
            img.src = URL.createObjectURL(file);
            img.classList.add("w-64", "h-64", "m-2", "rounded-md");

            const removeBtn = document.createElement("button");
            removeBtn.innerHTML = "Remove";
            removeBtn.classList.add("remove-img-button")

            wrapper.appendChild(img);
            wrapper.appendChild(removeBtn);

            removeBtn.addEventListener("click", (e) => {
                e.preventDefault();
                this.removeImage(index);
                e.target.parentElement.remove()
            });

            this.imagesContainerTarget.appendChild(wrapper);
        });
    }

    updateInputFiles() {
        const dataTransfer = new DataTransfer()
        this.files.forEach(file => dataTransfer.items.add(file))
        this.inputTarget.files = dataTransfer.files
    }

    removeImage(index) {
        this.files.splice(index, 1)
        this.updateInputFiles()
    }

    removeAttachedImage(e) {
        e.target.parentElement.remove()
    }
}
