// Creates a shadow DOM and moves all children into it
customElements.define("x-with-shadow-dom", class extends HTMLElement {
  constructor() {
    super();
    var shadowRoot = this.attachShadow({mode: "open"});
    while (this.firstChild) {
      shadowRoot.appendChild(this.firstChild);
    }
    var observer = new MutationObserver(mutationList => {
      mutationList.forEach((mutation) => {
        switch(mutation.type) {
          case 'childList':
            while (this.firstChild) {
              shadowRoot.appendChild(this.firstChild);
            }
            break;
        }
      });
    });
    observer.observe(this, {childList: true, subtree: false});
  }
});
