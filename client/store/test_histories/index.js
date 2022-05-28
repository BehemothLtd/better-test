import { getField, updateField } from "vuex-map-fields";
const SET_TEST_SESSION = "SET_TEST_SESSION";

export default {
  namespaced: true,
  state: () => ({
    test_session: [],
  }),

  getters: {
    getField,
  },

  actions: {
    getTestSession({ commit }, id) {
      return this.$axios.get(`test_sessions/${id}`).then((response) => {
        commit(SET_TEST_SESSION, response.data);
      });
    },
  },

  mutations: {
    updateField,

    SET_TEST_SESSION(state, payload) {
      state.test_session = payload;
    },
  },
};
