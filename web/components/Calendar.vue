<script>
import { defineComponent } from 'vue'
import FullCalendar from '@fullcalendar/vue3'
import dayGridPlugin from '@fullcalendar/daygrid'
import timeGridPlugin from '@fullcalendar/timegrid'
import interactionPlugin from '@fullcalendar/interaction'
import { INITIAL_EVENTS, createEventId } from '../utils/event-utils.js'
import {dateFormatToCalendar} from "~/utils/functions/dateFormatToCalendar.js";
import * as events from "events";

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
          right: 'timeGridWeek,timeGridDay'
        },
        initialView: 'timeGridWeek',
        initialEvents: this.addAllEvents(), // alternatively, use the `events` setting to fetch from a feed
        editable: false,
        selectable: false,
        selectMirror: true,
        dayMaxEvents: false,
        weekends: true,
        firstDay: 1,
        //select: this.handleDateSelect,
        //eventClick: this.handleEventClick,
        eventsSet: this.handleEvents
        /* you can update a remote database when these fire:
        eventAdd:
        eventChange:
        eventRemove:
        */
      },
      currentEvents: [],
    }
  },
  methods: {
    addEvent(cours) {
      const newEvent=  {
        id: createEventId(),
        title: cours.summary,
        start: dateFormatToCalendar(cours.startDate),
        end: dateFormatToCalendar(cours.endDate),
      }
      console.log(
          "newEvent : ", newEvent
      )
      return newEvent

    },

    addAllEvents() {
      console.log(
          "props : ", this.event
      )
      const eventsTable = []
      this.event.forEach((cours) => {
        eventsTable.push(this.addEvent(cours))
      })

      console.log("all EVENTS", eventsTable)
      return eventsTable
    },


    /**
    handleDateSelect(selectInfo) {
      let title = prompt('Please enter a new title for your event')
      let calendarApi = selectInfo.view.calendar

      calendarApi.unselect() // clear date selection

      if (title) {
        calendarApi.addEvent({
          id: createEventId(),
          title,
          start: selectInfo.startStr,
          end: selectInfo.endStr,
          allDay: selectInfo.allDay
        })
      }
    },

    handleEventClick(clickInfo) {
      if (confirm(`Are you sure you want to delete the event '${clickInfo.event.title}'`)) {
        clickInfo.event.remove()
      }
    },
    **/
    handleEvents(events) {
      this.currentEvents = events
    },

  },

})

</script>

<template>
  <div class='app'>
    <div class='app-sidebar'>
      <div class='app-sidebar-section'>
        <h2>All Events ({{ currentEvents.length }})</h2>
        <ul>
          <li v-for='event in currentEvents' :key='event.id'>
            <b>{{ event.startStr }}</b>
            <i>{{ event.title }}</i>
          </li>
        </ul>
      </div>
    </div>
    <div class='app-main'>
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
  min-height: 100%;
  font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
  font-size: 14px;
}

.app-sidebar {
  width: 300px;
  line-height: 1.5;
  background: #eaf9ff;
  border-right: 1px solid #d3e2e8;
}

.app-sidebar-section {
  padding: 2em;
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
