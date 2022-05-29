import { getField, updateField } from "vuex-map-fields";
const SET_SCREEN = "SET_SCREEN";
const SET_ELEMENTS = "SET_ELEMENTS";

export default {
  namespaced: true,
  state: () => ({
    screens: [],
    screen: {},
    test_cases: [],
  }),

  getters: {
    getField,
  },

  actions: {
    getScreen({ state, commit }, id) {
      try {
        return this.$axios.get(`screens/${id}`).then((response) => {
          commit(SET_SCREEN, response.data);
        });
      } catch (error) {}
    },

    getTestCases({ commit }, id) {
      return this.$axios.get(`screens/${id}/test_cases/`).then((response) => {
        commit(SET_ELEMENTS, response.data);
      });
    },
  },

  mutations: {
    updateField,
    SET_SCREEN(state, payload) {
      state.screen = payload;
    },
    SET_ELEMENTS(state, payload) {
      state.test_cases = payload;
    },
  },
};
