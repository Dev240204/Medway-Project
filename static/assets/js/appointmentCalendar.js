let appointmentCalendar;
document.addEventListener("DOMContentLoaded", function () {
  var calendarEl = document.getElementById("AppointmentCalendar");
  var calendarEvents = document.getElementById("calendar-events");
  var todayEvents = [];

  appointmentCalendar = new FullCalendar.Calendar(calendarEl, {
    selectable: true,
    initialView: "resourceTimelineDay",
    schedulerLicenseKey: "CC-Attribution-NonCommercial-NoDerivatives",
    headerToolbar: {
      left: "prev,next today",
      center: "title",
      right: "resourceTimelineWeek,resourceTimelineDay",
    },
    resourceAreaColumns: [
      {
        field: "title",
        headerContent: "Doctor Name",
        width: 100,
      },
    ],
    // resources: [
    //   { id: "a", title: "Dr. Strange" },
    //   { id: "b", title: "Thanos" },
    //   { id: "c", title: "Thor" },
    // ],
    resources: doctors.map((doctor) => ({ id: doctor.id, title: doctor.name })),
    events: appointments.map((appointment) => {
      let appointmentDate = new Date(
        `${appointment.date}T${appointment.time.split(".")[0]}`
      );
      return {
        resourceId: appointment.doctor_id,
        title: appointment.name,
        start: `${appointment.date}T${appointment.time.split(".")[0]}`,
        end: `${
          new Date(
            appointmentDate.setMinutes(
              appointmentDate.getMinutes() + appointment.estimated_time_required
            )
          )
            .toISOString()
            .split(".")[0]
        }`,
        extendedProps: {
          estimatedTime: appointment.estimated_time_required,
        },
      };
    }),
    // events: [
    //   {
    //     resourceId: "a",
    //     title: "Vue Vixens Day",
    //     start: "2023-09-22T10:00:00",
    //     end: "2023-09-22T12:00:00",
    //   },
    //   {
    //     resourceId: "b",
    //     title: "VueConfUS",
    //     start: "2023-09-22T10:00:00",
    //     end: "2023-09-22T11:00:00",
    //   },
    //   {
    //     resourceId: "c",
    //     title: "VueJS Amsterdam",
    //     start: "2023-09-22T11:00:00",
    //     end: "2023-09-22T12:00:00",
    //   },
    //   {
    //     resourceId: "a",
    //     title: "Vue Fes Japan 2019",
    //     start: "2023-09-23T13:00:00",
    //     end: "2023-09-23T13:30:00",
    //   },
    //   {
    //     resourceId: "b",
    //     title: "Laracon 2021",
    //     start: "2021-09-22T10:00:00",
    //     end: "2021-09-22T10:30:00",
    //   },
    // ],
    dateClick: function (info) {
      alert("clicked " + info.dateStr + " on resource " + info.resource.id);
    },
    select: function (info) {
      let selectedFromDate = new Date(info.startStr);
      let selectedToDate = new Date(info.endStr);
      let startTimeHr = selectedFromDate.getHours();
      let startTimeMin = selectedFromDate.getMinutes();
      let endTimeHr = selectedToDate.getHours();
      let endTimeMin = selectedToDate.getMinutes();
      if (startTimeHr < 10) {
        startTimeHr = "0" + startTimeHr;
      }
      if (startTimeMin < 10) {
        startTimeMin = "0" + startTimeMin;
      }
      if (endTimeHr < 10) {
        endTimeHr = "0" + endTimeHr;
      }
      if (endTimeMin < 10) {
        endTimeMin = "0" + endTimeMin;
      }

      // let startTime =
      //   selectedFromDate.getHours() + ":" + selectedFromDate.getMinutes();
      // let endTime =
      //   selectedToDate.getHours() + ":" + selectedToDate.getMinutes();

      let startTime = startTimeHr + ":" + startTimeMin;
      let endTime = endTimeHr + ":" + endTimeMin;

      window.location.replace(
        `/hospital/form?date=${
          selectedFromDate.toISOString().split("T")[0]
        }&startTime=${startTime}&endTime=${endTime}`
      );

      alert(
        info.startStr +
          "selected " +
          info.startStr.substr(0, 10) +
          " from " +
          info.startStr.substr(11, 16) +
          " to " +
          info.endStr +
          " on resource " +
          info.resource.id
      );
    },
    eventDidMount: function (info) {
      var today = new Date();
      var eventStart = info.event.start;

      if (
        eventStart.getDate() === today.getDate() &&
        eventStart.getMonth() === today.getMonth() &&
        eventStart.getFullYear() === today.getFullYear()
      ) {
        todayEvents.push({
          title: info.event.title,
          start: info.event.start,
          end: info.event.end,
          estimatedTime: info.event.extendedProps.estimatedTime,
        });
      }
    },
  });

  appointmentCalendar.render();
  // appointmentCalendar.addEvent(event);

  // Add the Events scheduled for today in side section
  if (todayEvents.length === 0) {
    calendarEvents.innerHTML = `<div class="text-center text-slate-500 p-3">No events scheduled for today</div>`;
  } else {
    todayEvents.forEach((event) => {
      console.log(event);
      let div = document.createElement("div");
      div.classList.add("relative");
      let div2 = `
      <div class="event p-3 -mx-3 cursor-pointer transition duration-300 ease-in-out hover:bg-slate-100 dark:hover:bg-darkmode-400 rounded-md flex items-center">
            <div class="w-2 h-2 bg-pending rounded-full mr-3"></div>
            <div class="pr-10">
                <div class="event__title truncate">${event.title}</div>
                <div class="text-slate-500 text-xs mt-0.5"> <span class="event__days">${
                  event.estimatedTime
                }</span>
                    Mins <span class="mx-1">•</span>${event.start.toLocaleTimeString(
                      "en-IN",
                      { hour: "numeric", hour12: true }
                    )}</div>
            </div>
      </div>`;
      let a = document.createElement("a");
      a.classList.add(
        "flex",
        "items-center",
        "absolute",
        "top-0",
        "bottom-0",
        "my-auto",
        "right-0"
      );
      a.innerHTML = `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" icon-name="edit" data-lucide="edit" class="lucide lucide-edit w-4 h-4 text-slate-500"><path d="M11 4H4a2 2 0 00-2 2v14a2 2 0 002 2h14a2 2 0 002-2v-7"></path><path d="M18.5 2.5a2.121 2.121 0 013 3L12 15l-4 1 1-4 9.5-9.5z"></path></svg>`;
      a.addEventListener("click", () => {
        alert("do some action");
      });

      div.innerHTML = div2;
      div.appendChild(a);
      calendarEvents.appendChild(div);
    });
  }

  // appointmentCalendar.gotoDate("2023-08-05");

  // Simple Monthly Calendar -- start
  const day = document.querySelector(".calendar-dates");
  const currdate = document.querySelector(".calendar-current-date");
  const prenexIcons = document.querySelectorAll(".monthPrevNext");
  // Array of month names
  const months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  let date = new Date();
  let year = date.getFullYear();
  let month = date.getMonth();

  const manipulate = () => {
    // clear innerHTML of day
    day.innerHTML = "";

    // Get the first day of the month
    let dayone = new Date(year, month, 1).getDay();

    // Get the last date of the month
    let lastdate = new Date(year, month + 1, 0).getDate();

    // Get the day of the last date of the month
    let dayend = new Date(year, month, lastdate).getDay();

    // Get the last date of the previous month
    let monthlastdate = new Date(year, month, 0).getDate();

    // Variable to store the generated calendar HTML
    let lit = "";

    let datesToBeAdded = [];

    // Loop to add the last dates of the previous month
    for (let i = dayone; i > 0; i--) {
      let d = document.createElement("div");
      d.classList.add("py-0.5", "rounded", "relative", "text-slate-500");
      d.innerText = monthlastdate - i + 1;
      d.addEventListener("click", (currDate) => {
        appointmentCalendar.gotoDate(
          `${year}-${month.toString().length === 1 ? "0" + month : month}-${
            (monthlastdate - i + 1).toString().length === 1
              ? "0" + (monthlastdate - i + 1)
              : monthlastdate - i + 1
          }`
        );
      });
      datesToBeAdded.push(d);

      // lit += `<li class="inactive">${monthlastdate - i + 1}</li>`;
      // lit += `<div class="py-0.5 rounded relative text-slate-500">${
      //   monthlastdate - i + 1
      // }</div>`;
    }

    // Loop to add the dates of the current month
    for (let i = 1; i <= lastdate; i++) {
      // Check if the current date is today
      let isToday =
        i === date.getDate() &&
        month === new Date().getMonth() &&
        year === new Date().getFullYear()
          ? "today"
          : "date";

      let d = document.createElement("div");
      d.classList.add("py-0.5", "rounded", "relative", `${isToday}`);
      d.innerText = i;
      d.addEventListener("click", (currDate) => {
        appointmentCalendar.gotoDate(
          `${year}-${
            (month + 1).toString().length === 1 ? "0" + (month + 1) : month + 1
          }-${i.toString().length === 1 ? "0" + i : i}`
        );
      });
      datesToBeAdded.push(d);

      // lit += `<li class="${isToday}">${i}</li>`;
      // lit += `<div class="py-0.5 rounded relative ${isToday}">${i}</div>`;
    }

    // Loop to add the first dates of the next month
    for (let i = dayend; i < 6; i++) {
      let d = document.createElement("div");
      d.classList.add("py-0.5", "rounded", "relative", "text-slate-500");
      d.innerText = i - dayend + 1;
      d.addEventListener("click", (currDate) => {
        appointmentCalendar.gotoDate(
          `${year}-${
            ((month + 2) % 12).toString().length === 1
              ? "0" + ((month + 2) % 12)
              : (month + 2) % 12
          }-${
            (i - dayend + 1).toString().length === 1
              ? "0" + (i - dayend + 1)
              : i - dayend + 1
          }`
        );
      });
      datesToBeAdded.push(d);

      // lit += `<li class="inactive">${i - dayend + 1}</li>`;
      // lit += `<div class="py-0.5 rounded relative text-slate-500">${
      //   i - dayend + 1
      // }</div>`;
    }

    // Update the text of the current date element
    // with the formatted current month and year
    currdate.innerText = `${months[month]} ${year}`;

    // update the HTML of the dates element
    // with the generated calendar
    datesToBeAdded.forEach((d) => {
      day.append(d);
    });

    // day.innerHTML = lit;
  };

  manipulate();

  // Attach a click event listener to each icon
  prenexIcons.forEach((icon) => {
    // When an icon is clicked
    icon.addEventListener("click", () => {
      // Check if the icon is "calendar-prev"
      // or "calendar-next"
      month = icon.id === "calendar-prev" ? month - 1 : month + 1;

      // Check if the month is out of range
      if (month < 0 || month > 11) {
        // Set the date to the first day of the
        // month with the new year
        console.log(year, month, new Date().getDate());
        date = new Date(year, month, new Date().getDate());

        // Set the year to the new year
        year = date.getFullYear();

        // Set the month to the new month
        month = date.getMonth();
      } else {
        // Set the date to the current date
        date = new Date();
        console.log(year, month, new Date().getDate());
      }

      // Call the manipulate function to
      // update the calendar display
      manipulate();
    });
  });

  // Simple Monthly Calendar -- end
});

function printSchedule() {
  var divContents = document.getElementById("AppointmentCalendar").innerHTML;
  var a = window.open("", "", "height=500, width=500");
  a.document.write("<html>");
  a.document.write("<body > <h1>Div contents are <br>");
  a.document.write(divContents);
  a.document.write("</body></html>");
  a.document.close();
  a.print();
}
