import React from 'react';
import CustomerItem from '../../src/components/CustomerItem';

export default function CustomersPage({customers}) {
  return <div>
    {
      customers.map(customer => <CustomerItem key={customer.id} customer={customer}/>)
    }
  </div>;
}
