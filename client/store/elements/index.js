import { getField, updateField } from "vuex-map-fields";
const SET_IMAGE_ELEMENT = "SET_IMAGE_ELEMENT";

export default {
  namespaced: true,
  state: () => ({
    elements: [],
    element: {
      name: "",
      selector_type: "css",
      selector_path: "",
      auth_id: null,
      image: "",
      screen_id: 1,
    },
  }),

  getters: {
    getField,
  },

  actions: {
    createElement({ state }) {
      try {
        return this.$axios.post("elements", state.element);
      } catch (error) {}
    },
    capImage(params) {
      return this.$axios
        .post("elements/capture_image", params)
        .then((response) => {
          commit(SET_IMAGE_ELEMENT, response);
        });
    },
  },

  mutations: {
    updateField,
    SET_IMAGE_ELEMENT(state, payload) {
      state.element.image = payload;
    },
  },
};
