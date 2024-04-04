<script>
import {defineComponent} from 'vue'
import FullCalendar from '@fullcalendar/vue3'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import interactionPlugin from '@fullcalendar/interaction'
import {createEventId} from '../utils/createEventId.js'
import {dateFormatToCalendar} from "~/utils/functions/dateFormatToCalendar.js";
import {getHeureFormatee} from "~/utils/functions/getHeureFormatee.js";

export default defineComponent({
  components: {
    FullCalendar,
  },
  props: ['event'],
  data() {
    return {
      calendarOptions: {
        plugins: [
          dayGridPlugin,
          timeGridPlugin,
          interactionPlugin // needed for dateClick
        ],
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'timeGridDay, timeGridWeek'
        },
        initialView: 'timeGridWeek',
        initialEvents: this.addAllEvents(), // alternatively, use the `events` setting to fetch from a feed
        editable: false,
        selectable: false,
        selectMirror: true,
        dayMaxEvents: false,
        weekends: true,
        firstDay: 1,
        allDaySlot: false,
        locale: 'fr',
        eventClick: this.handleEventClick,
      },

      currentEvents: [],
      infoEvent: "",
      popupShow: false,
      infoPopup: {},
    }
  },
  methods: {
    getHeureFormatee,
    addEvent(cours) {
      const newEvent = {
        id: createEventId(),
        title: cours.summary,
        start: dateFormatToCalendar(cours.startDate),
        end: dateFormatToCalendar(cours.endDate),
      }
      return newEvent

    },

    addAllEvents() {
      const eventsTable = []
      this.event.forEach((cours) => {
        eventsTable.push(this.addEvent(cours))
      })
      return eventsTable
    },

    handleEventClick(clickInfo) {
      this.infoPopup = clickInfo
      this.popupShow = true
    },

  },

})

</script>

<template>
  <div class='app'>
    <div class='app-main'>
      <Popup :is-open="popupShow" @modal-close="args => {this.popupShow=false}">
        <template v-slot:header>
          <h2>Detail du cours</h2>
        </template>

        <template v-slot:content>
          <ul>
            <li>
              <b> {{ this.infoPopup.event.title }}</b>
            </li>
            <li>
              <b>Début :</b> {{ getHeureFormatee(this.infoPopup.event.startStr) || 'Inconnue' }}
            </li>
            <li>
              <b>Fin :</b> {{ getHeureFormatee(this.infoPopup.event.endStr) || 'Inconnue' }}
            </li>

            <li>
              <b> Salle :</b> {{ event[0].location || 'Inconnue' }}
            </li>

          </ul>
        </template>

        <template v-slot:footer>
          <div>
            <button @click.stop="popupShow=false">Fermer</button>
          </div>
        </template>
      </Popup>
      <FullCalendar
          class='app-calendar'
          :options='calendarOptions'
      >
        <template v-slot:eventContent='arg'>
          <b>{{ arg.timeText }}</b>
          <i>{{ arg.event.title }}</i>
        </template>
      </FullCalendar>
    </div>
  </div>
</template>

<style lang='css'>

h2 {
  margin: 0;
  font-size: 16px;
}

ul {
  margin: 0;
  padding: 0 0 0 1.5em;
}

li {
  margin: 1.5em 0;
  padding: 0;
}

b { /* used for event dates/times */
  margin-right: 3px;
}

.app {
  display: flex;
  min-height: 300px;
  font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
  font-size: 14px;
}


.app-main {
  flex-grow: 1;
  padding: 3em;
}

.fc { /* the calendar root */
  max-width: 1100px;
  margin: 0 auto;
}

</style>
