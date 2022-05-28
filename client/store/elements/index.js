import { getField, updateField } from "vuex-map-fields";

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
    async createElement({ state, dispatch }, params) {
      try {
        const res = await this.$axios.post("elements", params);

        dispatch("screens/getScreen", params.screen_id, { root: true });
        return res;
      } catch (error) {}
    },
    async capImage(_, params) {
      try {
        const res = await this.$axios.post("elements/capture_image", params);
        return res;
      } catch (error) {
        console.log(error);
      }
    },
    async updateElement({ state, dispatch }, params) {
      try {
        await this.$axios.put(`elements/${params.id}`, params);
        dispatch("screens/getScreen", params.screen_id, { root: true });
      } catch (error) {}
    },

    async deleteElement({ dispatch }, params) {
      try {
        console.log(params);
        const res = await this.$axios.delete(`elements/${params.elementID}`);
        if (res) {
          this.$toast.success("Deleted");
          dispatch("screens/getScreen", params.id, { root: true });
        }
      } catch (error) {}
    },
  },

  mutations: {
    updateField,
  },
};
