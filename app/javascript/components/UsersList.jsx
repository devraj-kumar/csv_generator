import React, { useState, useEffect } from 'react';
import Download from './Download';

const UsersList = () => {
  const [users, setUsers] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    setLoading(true);

    const fetchUsers = async () => {
      try {
        const response = await fetch('/users');
        const data = await response.json();
        setUsers(data);
        setError(null);
      } catch (error) {
        setError('Failed to fetch users');
      } finally {
        setLoading(false);
      }
    };

    fetchUsers();
  }, []);

  if (loading) {
    return <div className="loading">Loading...</div>;
  }

  if (error) {
    return <div className="error">Error: {error}</div>;
  }

  return (
    <div className="users-list-container">
      <table className="users-list-table">
        <thead>
          <tr>
            <th className="table-header">Username</th>
            <th className="table-header">Email</th>
            <th className="table-header">Download(csv)</th>
          </tr>
        </thead>
        <tbody>
          {users.map((user, index) => (
            <tr key={index} className={index % 2 !== 0 ? 'odd-row' : 'even-row'}>
              <td className="table-cell">{user.username}</td>
              <td className="table-cell">{user.email}</td>
              <td className="table-cell"><Download userId={user.id}/></td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default UsersList;
