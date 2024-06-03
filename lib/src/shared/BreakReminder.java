import java.util.Timer;
import java.util.TimerTask;
import java.util.Random;
import java.util.Scanner;

public class BreakReminder {

    // Duration in milliseconds (e.g., 1 hour = 3600000 milliseconds)
    private static final long WORK_DURATION = 3600000; // 1 hour
    private static final String[] ACTIVITIES = {
            "Listen to music",
            "Do exercise",
            "Take a walk",
            "Drink water",
            "Stretch your legs",
            "Meditate for a few minutes"
    };

    public static void main(String[] args) {
        Timer timer = new Timer();
        TimerTask task = new TimerTask() {
            @Override
            public void run() {
                suggestBreak();
            }
        };

        // Schedule the task to run after WORK_DURATION and then repeat at WORK_DURATION intervals
        timer.schedule(task, WORK_DURATION, WORK_DURATION);

        // Keep the program running
        Scanner scanner = new Scanner(System.in);
        System.out.println("Break Reminder is running. Press Enter to exit...");
        scanner.nextLine();
        timer.cancel();
        scanner.close();
    }

    private static void suggestBreak() {
        Random random = new Random();
        String activity = ACTIVITIES[random.nextInt(ACTIVITIES.length)];
        System.out.println("\nTime for a break! How about you: " + activity + "?");
    }
}
