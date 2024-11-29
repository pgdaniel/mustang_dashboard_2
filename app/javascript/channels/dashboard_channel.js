import consumer from "./consumer"
(function () {
  let gear = 0;
  let speed = 0;
  let rpm = 0;
  let temp_f = 0;
  let oilPressure = 0;
  let gearComponent = document.getElementById("gear");
  let speedComponent = document.getElementById("speed");
  let rpmComponent = document.getElementById("rpm");
  let tempComponent = document.getElementById("temp");
  let oilPressureComponent = document.getElementById("pressure");

  consumer.subscriptions.create("DashboardChannel", {
    connected() {
    },

    disconnected() {
    },

    received(data) {
      // console.log(data)
      let vehicle = JSON.parse(data);

      if (vehicle.gear) {
        gear = parseInt(vehicle.gear);
        gearComponent.textContent = gear;
      }
      if (vehicle.mph) {
        speed = parseInt(vehicle.mph);
        speedComponent.textContent = speed;
      }
      if('engine' in vehicle) {
        let engine = vehicle.engine;

        if ('rpm' in engine) {
          rpm = parseInt(vehicle.engine.rpm);
          rpmComponent.textContent = rpm;
        }
        if ('temp_f' in engine) {
          temp_f = parseInt(vehicle.engine.temp_f);
          tempComponent.textContent = temp_f;
        }
        if ('oil_pressure_psi' in engine) {
          oilPressure = parseInt(vehicle.engine.oil_pressure_psi);
          oilPressureComponent.textContent = oilPressure;
        }
      }
    }
  });
})();