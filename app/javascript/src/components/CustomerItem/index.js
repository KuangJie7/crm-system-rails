import React from 'react';

export default function CustomerItem({customer}) {
  return <div>
    {JSON.stringify(customer)}
  </div>;
}
