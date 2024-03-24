import React from 'react';

class TimeFormatComponent extends React.Component {
  render() {
    const { timestamp } = this.props;
    
    if (!timestamp) {
      return null; // Handle cases where the timestamp is not available
    }

    const formattedTime = new Intl.DateTimeFormat('en-US', {
        month: 'long',
        day: '2-digit',
        year: 'numeric',
        hour: 'numeric',
        minute: 'numeric',
        hour12: true,
      }).format(new Date(timestamp));

    return <p className="text-xs text-gray-500">{formattedTime}</p>;
  }
}

export default TimeFormatComponent;
