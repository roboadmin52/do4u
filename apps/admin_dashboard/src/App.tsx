import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';

function App() {
  return (
    <Router>
      <div className="flex h-screen bg-gray-100">
        <div className="w-64 bg-slate-900 text-white p-6">
          <h1 className="text-xl font-bold">Do4U Admin</h1>
          <nav className="mt-8 space-y-4">
            <div className="text-gray-400">Dashboard</div>
            <div className="text-gray-400">Errands</div>
            <div className="text-gray-400">Runners</div>
          </nav>
        </div>
        <div className="flex-1 p-10">
          <Routes>
            <Route path="/" element={
              <div>
                <h2 className="text-3xl font-bold">Welcome Ahmed</h2>
                <p className="mt-2 text-gray-600">Here is your operational overview.</p>
              </div>
            } />
          </Routes>
        </div>
      </div>
    </Router>
  );
}

export default App;
