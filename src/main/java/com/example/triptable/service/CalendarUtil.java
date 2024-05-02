package com.example.triptable.service;

import java.time.LocalDate;

public class CalendarUtil {

    public static String generateCalendarHtml(int year, int month) {
        LocalDate currentDate = LocalDate.now();
        int currentYear = currentDate.getYear();
        int currentMonth = currentDate.getMonthValue();

        int selectedYear = (year != 0) ? year : currentYear;
        int selectedMonth = (month != 0) ? month : currentMonth;

        if (selectedMonth > 12) {
            selectedYear += selectedMonth / 12;
            selectedMonth = selectedMonth % 12;
        }

        LocalDate startCalendar = LocalDate.of(selectedYear, selectedMonth, 1);
        LocalDate endCalendar = LocalDate.of(selectedYear, selectedMonth, startCalendar.lengthOfMonth());

        int startDayOfWeek = startCalendar.getDayOfWeek().getValue() + 1;
        int endDay = endCalendar.getDayOfWeek().getValue();

        StringBuilder strCalendar = new StringBuilder();
        strCalendar.append("<table border='0' cellspacing='0' id='tablearea' class='tablearea'>");
        strCalendar.append("<caption>").append(selectedYear).append("년").append(selectedMonth).append("월").append("</caption>");
        strCalendar.append("<thead><tr align='center'>");

        String[] daysOfWeek = {"일", "월", "화", "수", "목", "금", "토" };

        for (String day : daysOfWeek) {
            strCalendar.append("<th>").append(day).append("</th>");
        }

        strCalendar.append("</tr></thead><tbody>");
        strCalendar.append("<tr>");

        for (int i = 1; i < startDayOfWeek; i++) {
            strCalendar.append("<td></td>");
        }

        for (int i = 1, n = startDayOfWeek; i <= endCalendar.getDayOfMonth(); i++, n++) {
            if (n % 7 == 1) {
                strCalendar.append("<tr>");
            }

            String cellClass = (LocalDate.of(selectedYear, selectedMonth, i).isBefore(currentDate)) ? "past-day" : "";

            strCalendar.append("<td class='").append(cellClass).append("'>").append(i).append("</td>");
            if (n % 7 == 0) {
                strCalendar.append("</tr>");
            }
        }

        for (int i = 0; i < 7 - endDay; i++) {
            if (endDay == 0) {
                continue;
            }
            strCalendar.append("<td></td>");
        }
        strCalendar.append("</tbody></table>");

        return strCalendar.toString();
    }
}