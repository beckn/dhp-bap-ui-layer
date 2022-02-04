// import { AgnosticFacetSearchParams } from '@vue-storefront/core';
// import { SearchItemsWhere } from '@vue-storefront/beckn-api';

export const buildSearchItemsWhere = (params) => {
  const paramsObj: { [k: string]: any } = {
    locationIs: params.locationIs,
    offset: params.page * params.itemsPerPage,
    limit: params.itemsPerPage,
    symptoms: params.symptoms
  };
  const { searchBy } = params;
  if (searchBy) {
    if (searchBy === 'consultations') {
      paramsObj.domain = 'consultations';
    } else if (searchBy === 'diagnostics') {
      // eslint-disable-next-line camelcase
      paramsObj.diagnostics = 'diagnostics';
    }
  } else if (params.term) {
    paramsObj.itemContains = params.term;
  }
  if (params.term) paramsObj.itemContains = params.term;
  if (params.providerId) paramsObj.providerId = params.providerId;
  return paramsObj;
};
