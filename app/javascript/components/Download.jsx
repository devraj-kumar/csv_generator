import React, { useState } from 'react'

const Download = ({ userId }) => {
  const [error, setError] = useState(null)
  const [loading, setLoading] = useState(false)

  const downloadReport = async (userId) => {
    console.log('downloadReport', userId)
    const response = await fetch(`/users/${userId}/download_report`)

    if (response.ok) {
      const { job_id } = await response.json()
      return job_id
    } else {
      setError('Error initiating download')
    }
  }

  const checkDownloadStatus = async (jobId) => {
    const response = await fetch(`/users/download_report_status?job_id=${jobId}`)

    if (response.ok) {
      const { status, file_link } = await response.json()

      if (status === 'complete' && file_link) {
        window.open(file_link, '_blank')
        setLoading(false)
      }

      return status
    } else {
      setError('Error checking download status')
    }
  }

  const handleDownload = async (userId) => {
    console.log('handleDownload', userId)

    setLoading(true)
    const jobId = await downloadReport(userId)

    if (jobId) {
      let status = 'pending'
      while (status === 'pending') {
        await new Promise(resolve => setTimeout(resolve, 3000)) // Poll every 3 second, just for slowing it down
        status = await checkDownloadStatus(jobId)
      }
    }
  }

  if (error) {
    return <span>Something went wrong</span>
  }

  return (
    <button onClick={() => handleDownload(userId)} disabled={loading}>
      {loading ? 'Your file is being generated' : 'Download'}
    </button>
  )
}

export default Download
