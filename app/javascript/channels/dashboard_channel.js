import consumer from "./consumer"

consumer.subscriptions.create("DashboardChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("DATA", data);

    let incomingData = JSON.parse(data);

    let result = incomingData.incoming_data;
    console.log("RESULT", result);

    switch(result) {
      case "speed":
        console.log("SPEED", result);
        let speedComponent = document.getElementById("speed");
        speedComponent.textContent = incomingData.data;
        break;
      case "rpm":
        console.log("RPM", result);
        let rpmComponent = document.getElementById("rpm");
        rpmComponent.textContent = incomingData.data;
        break;
      case "wheel_speed_1":
        console.log("WHEEL_SPEED 1", result);
        let wheelSpeedComponent1 = document.getElementById("wheel_speed_1");
        wheelSpeedComponent1.textContent = incomingData.data;
        break;
      case "wheel_speed_2":
        console.log("WHEEL_SPEED 2", result);
        let wheelSpeedComponent2 = document.getElementById("wheel_speed_2");
        wheelSpeedComponent2.textContent = incomingData.data;
        break;
      case "wheel_speed_3":
        console.log("WHEEL_SPEED 3", result);
        let wheelSpeedComponent3 = document.getElementById("wheel_speed_3");
        wheelSpeedComponent3.textContent = incomingData.data;
        break;
      case "wheel_speed_4":
        console.log("WHEEL_SPEED 4", result);
        let wheelSpeedComponent4 = document.getElementById("wheel_speed_4");
        wheelSpeedComponent4.textContent = incomingData.data;
        break;
      default:
        console.log("DEFAULT");
    }
  }
});
