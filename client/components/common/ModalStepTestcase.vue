<template>
  <b-modal ref="modal" hide-header hide-footer>
    <b-row class="align-items-center mt-3">
      <b-col sm="3">
        <label>Action :</label>
      </b-col>
      <b-col sm="9">
        <b-form-select
          v-model="step.command"
          :options="actions"
          @change="onCommandChange"
        ></b-form-select>
      </b-col>
    </b-row>

    <template v-if="step.command != 'open' && step.command != 'scenario'">
      <b-row class="align-items-center mt-3">
        <b-col sm="3">
          <label>Element</label>
        </b-col>
        <b-col sm="9">
          <b-form-select
            v-model="elementId"
            text-field="name"
            value-field="id"
            :options="elementOptions"
            @change="choseElement"
          ></b-form-select>
        </b-col>
      </b-row>
      <b-row class="align-items-center mt-3">
        <b-col sm="3">
          <label for="">Selector type</label>
        </b-col>
        <b-col sm="9">
          <b-input v-model="step.selector_type"></b-input>
        </b-col>
      </b-row>
      <b-row class="align-items-center mt-3">
        <b-col sm="3">
          <label for="">Selector path</label>
        </b-col>
        <b-col sm="9">
          <b-input v-model="step.selector_path"></b-input>
        </b-col>
      </b-row>
    </template>

    <b-row v-if="step.command == 'open'" class="align-items-center mt-3">
      <b-col sm="3">
        <label>Value</label>
      </b-col>
      <b-col sm="9">
        <b-input v-model="step.value" placeholder="http://asdasd"></b-input>
      </b-col>
    </b-row>
    <b-row v-if="step.command == 'input'" class="align-items-center mt-3">
      <b-col sm="3">
        <label>Value</label>
      </b-col>
      <b-col sm="9">
        <b-input v-model="step.value" placeholder="value"></b-input>
      </b-col>
    </b-row>
    <div v-if="step.command == 'wait'">
      <b-row class="align-items-center mt-3">
        <b-col sm="3">
          <label>Wait for</label>
        </b-col>
        <b-col sm="9">
          <b-form-select v-model="waitFor" :options="waits"></b-form-select>
        </b-col>
      </b-row>
      <b-row v-if="waitFor == 'seconds'" class="align-items-center mt-3">
        <b-col sm="3">
          <label>Value</label>
        </b-col>
        <b-col sm="9">
          <div class="postion-relative">
            <b-input v-model="step.value" placeholder="10"></b-input>
            <span class="unit">-/+(s)</span>
          </div>
        </b-col>
      </b-row>
    </div>
    <div v-if="step.command == 'scenario'">
      <b-row class="align-items-center mt-3">
        <b-col sm="3">
          <label>Scenario</label>
        </b-col>
        <b-col sm="9">
          <b-form-select
            v-model="step.value"
            :options="scenarios"
            text-field="name"
            value-field="id"
          ></b-form-select>
        </b-col>
      </b-row>
    </div>
    <div v-if="step.command == 'assert'">
      <b-row class="align-items-center mt-3">
        <b-col sm="3">
          <label>Equal</label>
        </b-col>
        <b-col sm="9">
          <b-input v-model="step.value" placeholder="value"></b-input>
        </b-col>
      </b-row>
    </div>
    <div class="mt-3 text-right">
      <b-button variant="primary" @click="submit">Submit</b-button>
    </div>
  </b-modal>
</template>
<script>
import _ from "lodash";

export default {
  props: {
    isScenario: false,
  },
  data() {
    return {
      step: {
        name: "",
        command: "click",
        value: "",
        selector_type: "",
        selector_path: "",
      },
      elementId: null,
      waits: [
        { value: "element", text: "Element" },
        { value: "seconds", text: "Seconds" },
      ],
      elementOptions: [],
      scenarios: [],
      editing: false,
    };
  },
  computed: {
    waitFor: {
      get() {
        if (this.step.selector_path && this.step.selector_type) {
          return "element";
        } else {
          return "seconds";
        }
      },
      set(value) {
        if (value === "seconds") {
          this.elementId = null;
          this.step.selector_type = "";
          this.step.selector_path = "";
          this.step.name = "";
        } else {
          this.step.value = "";
        }
      },
    },
    actions() {
      const actions = [
        { value: "click", text: "Click" },
        { value: "open", text: "Open" },
        { value: "input", text: "Input" },
        { value: "wait", text: "Wait" },
        { value: "assert", text: "Assert" },
      ];

      if (!this.isScenario) {
        return [...actions, { value: "scenario", text: "Scenario" }];
      }

      return actions;
    },
  },
  mounted() {
    this.fetchScenarios();
  },
  methods: {
    async show(data) {
      const screenID = this.$route.params.screenId;
      if (this.isScenario) {
        const res = await this.$axios.get("elements");
        this.elementOptions = res.data;
      } else {
        const res = await this.$axios.get(`screens/${screenID}`);
        this.elementOptions = res.data.elements;
      }

      this.editing = !!data;
      this.$refs.modal.show();
      if (data) {
        this.step = _.cloneDeep(data);
      } else {
        this.step = {
          command: "click",
          value: "",
          selector_type: "",
          selector_path: "",
        };
      }
    },
    submit() {
      if (this.editing) {
        this.$emit("update", this.step);
      } else {
        this.$emit("create", this.step);
      }
      this.hide();
    },
    async fetchScenarios() {
      const res = await this.$axios.get(
        `/scenarios?project_id=` + this.$route.params.id
      );
      this.scenarios = res.data;
    },
    hide() {
      this.$refs.modal.isVisible = false;
    },
    choseElement(value) {
      const selected = this.elementOptions.find((item) => item.id === value);

      if (selected) {
        this.step.selector_type = selected.selector_type;
        this.step.selector_path = selected.selector_path;
        this.step.name = selected.name;
      } else {
        this.step.selector_type = "";
        this.step.selector_path = "";
        this.step.name = "";
      }
    },
    onCommandChange(value) {
      switch (value) {
        case "open":
        case "scenario":
          this.step.name = "";
          break;
      }
    },
  },
};
</script>
