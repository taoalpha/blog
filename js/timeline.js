(() => {
    class Timeline {
        constructor() {
            this.data = [];
            this.api_last_update = new Date();
            this.getFromAPI().then(() => this.render()).catch(e => {
                window.showAlert("fail", "Fail to load the timeline data!");
            });
        }
        render() {
            var renderHTML = '';
            this.data.sort((a, b) => b.start_date.localeCompare(a.start_date));
            this.data.forEach((entry, i) => {
                renderHTML += `
        <div class='timeline-wrapper'>
          <i class='fas fa-check'></i>
          <h2 class='timeline-time date-title'>
            <span>${entry.start_date} - ${entry.end_date} @ ${entry.country}</span>
          </h2>
      `;
                (entry.items || []).reverse().forEach((item, j) => {
                    renderHTML += `
          <dl class='timeline-series'>
            <dt class='timeline-event ${!item.desc && "no-desc"}'>
              <a class='closed timeline-item-title'>${item.title}</a>
            </dt>
            ${item.desc ? `
              <dd class='timeline-event-content hidden'>
                <p class='timeline-item-desc'>${item.desc}</p>
              </dd>` : ""}
          </dl>`;
                });
                renderHTML += "</div><br class='clear'>";
            });
            document.querySelector('#timeline').innerHTML = renderHTML;
            this.setupListeners();
        }
        setupListeners() {
            document.querySelectorAll('dt.timeline-event').forEach(el => {
                el.addEventListener('click', () => {
                    const dd = el.nextElementSibling;
                    if (dd) {
                        dd.classList.toggle('hidden');
                        window.animateCSS(dd, ["fadeIn"]);
                    }
                });
            });
        }
        getFromAPI() {
            return fetch("https://api.github.com/gists/aa2a829c5a4f77cead7f6310db6809de")
                .then(r => r.json())
                .then(res => {
                return JSON.parse(res.files['timeline.json'].content);
            })
                .catch(e => {
                return this.getFromLocal();
            })
                .then(data => {
                this.api_last_update = data.last_update;
                this.data = data.entries || [];
            });
        }
        getFromLocal() {
            return fetch("/blog/api/timeline.json")
                .then(r => r.json());
        }
    }
    new Timeline();
})();
//# sourceMappingURL=timeline.js.map